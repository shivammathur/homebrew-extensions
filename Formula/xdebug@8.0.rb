# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "53c28f207ba71cf9cfe509ba7cd4643ac6aaaaf56ad4da7d1ee7504a36dd9fc9"
    sha256                               arm64_sequoia: "692bad6433df9b402ea0eda8af30fd8af46b287633421b2a3d41c6090888c374"
    sha256                               arm64_sonoma:  "1cabc7e3b8270cbb43e22344e2bfcc89d2d80ebc9a9d403ec677e2f83f408260"
    sha256 cellar: :any_skip_relocation, sonoma:        "2f2eae88c7892ee64cd80b5ca42c3cecd603e2d408317dc1e7ee5087ca255228"
    sha256                               arm64_linux:   "20864abe36194881ddf6766eb5b536f7bf555e80c790c8b20b84fce8892aac04"
    sha256                               x86_64_linux:  "c388e9623ad6c08c87bfa27976061d00a4abff769dab02ad99c906c6695bbe24"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
