opts=$'Update\nPush\nRebuild\nTrim\nQuit\nEnable Containers\nDisable Containers\nArch Push'
containers="/etc/nixos/containers"
res=$( echo "$opts" | fzf -q "$1" --prompt "Choose an option: " | cat)
if [ "$res" = "Quit" ]; then
 echo 
fi

if [ "$res" = "Update" ]; then
  git pull uorigin main
  echo "NixOS Rebuilding ..."
  sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log|grep --color error && false)
fi

if [ "$res" = "Push" ]; then
  echo "Getting generations ..."
  gen=$(nixos-rebuild list-genrations | grep current)
  echo "Pushing to repo ..."
  git commit -am "$gen"
  git push origin main
fi

if [ "$res" = "Rebuild" ]; then
    echo "Rebuilding ..."
    sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log|grep --color error && false)
fi
if [ "$res" = "Trim" ]; then
    echo "Trimming Generations"
    sudo nix-collect-garbage
fi
if [ "$res" = "Enable Containers" ]; then
   echo "Enabling Containers"
   for directory in "$containers"/*/; do
    # Navigate to the directory
    cd "$directory" || continue
    
    # Check if docker-compose.yml exists in the directory
    if [ -f docker-compose.yml ]; then
        # Bring up containers in detached mode
        docker-compose up -d
    fi
done
fi
if [ "$res" = "Disable Containers" ]; then
   echo "Enabling Containers"
   for directory in "$containers"/*/; do
    # Navigate to the directory
    cd "$directory" || continue
    
    # Check if docker-compose.yml exists in the directory
    if [ -f docker-compose.yml ]; then
        # Bring up containers in detached mode
        docker-compose down
    fi
done
fi

if [ "$res" = "Arch Push" ]; then
  echo "Pushing to repo ..."
  git commit -a 
  git push
fi

