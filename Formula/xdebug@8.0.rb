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
    sha256                               arm64_tahoe:   "2c4e8aa646740a7fd65cd3e345ded753e9cce8847c5ab61c3b1d725d69e3d5ea"
    sha256                               arm64_sequoia: "cc4e7107a31db48ae48d5499b5a3fd2fc90bd3a3bbf2dda81e91b1e2da9bb801"
    sha256                               arm64_sonoma:  "96b4b899a7793d5e3ce8402a535b1a4d169e2ac337ae044b9eb9f08c08385a19"
    sha256 cellar: :any_skip_relocation, sonoma:        "d97f5ba3f810c3a67fd94519de7e81874aa989cbc641cbe0ffbc00fd45f92a9d"
    sha256                               arm64_linux:   "3d09b0de069837bf29c052bddf6b68e21920b4d782fd1198ddb3c5b681a87746"
    sha256                               x86_64_linux:  "4e163f1cf5fdd79e59fffd3f4d093ea7e7e1d5352a2873c95681a988fd58d610"
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
