# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT56 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-0.6.1.tgz"
  sha256 "57ccc6293ddb56b3cae2620bb3dc00f145d5edb42e38b160d93ed968fcbb1bae"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "30a68356eaf094e2a9811ae20cd5a1453c5d1786e6f5f7dbbac6659da4c913c6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "94edc7294ebc09b22b3450ebc6c1d1a72c98e3d744ba0051b880b8d00fe5cedb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ce9522a23364cb1aebfb5350753335a07f28d43291bb8b5174e963dcbba3d948"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2aa228bc744b0e5c402c5409f4505236092063c91a5231cd6c4f0ac129a98c56"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "00acfce6e643073d6cc012f253e7802c12b3dbd2cf05017940d5d0e3cb98bf4a"
    sha256 cellar: :any_skip_relocation, ventura:        "6dd0b4104fb26d7e22c606df684dedfa4ef9af8615900ba709bd766fff7909f3"
    sha256 cellar: :any_skip_relocation, monterey:       "660f7c481d6867cf7b1453d530fbd20a49f2cfdae7ab5dd726eecff62726ab2f"
    sha256 cellar: :any_skip_relocation, big_sur:        "1fc0953647001eb2b10a2aa85a9c5c27519cab5679ddc5282ebed1908a4ce74e"
    sha256 cellar: :any_skip_relocation, catalina:       "f2529a4c8824202623afbaaa206dee0bb3bcd9540ac128e7bd7396f53df649e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "cb1ef5a2346cb2b5a31363069660f98e645802adcd7ad76d9acb35da75551334"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66422afbbe5f58c90641fb1da734306bd7264f7e8323950d06bf468c02e05d94"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
