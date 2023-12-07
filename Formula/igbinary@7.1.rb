# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2f1575ae7607c6363e9a446d7b565822e809a9dbd1941812e9e3f7a9080aabee"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "84057d948c07fbd514d63e0e1af12c4f2318ec8656c246e37ecb2887b8571d92"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "27a3e669d841a6e480d567fe2d84479cc10cd212441d5500b7b22605cf47ec05"
    sha256 cellar: :any_skip_relocation, ventura:        "f5509296b1c9457eea7fa1a2c5bcfc1b59315f42c15e970136f3d8a4cd4f42bb"
    sha256 cellar: :any_skip_relocation, monterey:       "3eef7003202ec7afb535b1368a160e94a4ec7e006102b7f651121fad3e46720e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb234e22b79909544e83b4fa0434626baf613236d9ef065136392c8e70ee83b3"
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
