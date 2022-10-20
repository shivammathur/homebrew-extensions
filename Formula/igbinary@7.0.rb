# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ee04dfe148773e18179d1a1255a39e7ea59be8540917498cf3e2654b03746a5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "307cf23a08dc18a86e5c9870f465b80ae04e3bd16d1d6f3a4c3987a28780e7fa"
    sha256 cellar: :any_skip_relocation, monterey:       "490e25767895ab7e004507d9b08397232f5bc98acae9a11b9bdb79350a9903a9"
    sha256 cellar: :any_skip_relocation, big_sur:        "2e53a7df9910735252126b27091f1dca6b94de4f1168eb40583b6d3d34f9afb0"
    sha256 cellar: :any_skip_relocation, catalina:       "f0e58584a5cb8cb263605ff0fe55ac7087c3752e4ab4add9f68cf7f31e1ebb5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "08c9676907af64eefc0b0a23e392264dfaa534388914c317afd55bf47d91045a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
