# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT84 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9bb331fc8ec691c7dee6fb3d6c917a3e3ac5ce3abc562e7bd05a65f12d0e5ded"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "71943a9a17111017c6b31b51c16f9d9b3f8b5d555aadae96763d1d32b1f12e11"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "84cdede3daeae65d6091daec0bfd61668ca1a87b7092433552fd7bf714562d2e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "640f20885bcd4f8bbfed7139f361c404d1d377fa34c99481a2bbd7261c6378ca"
    sha256 cellar: :any_skip_relocation, ventura:        "5e490fe89ecd41acc60e26af4d5286ad5298291e500ec43911b34413b62d5b66"
    sha256 cellar: :any_skip_relocation, monterey:       "3d4c25ad21ccd9fa857e2b6cf5b2e7142eb3eb594a736d33cf933ae281a5078a"
    sha256 cellar: :any_skip_relocation, big_sur:        "fa28759dfc0741acd7fdc89a8fa03983e8b9c5a41ee57bd01e76b4d04e9a4afc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "345a86cd641a4b6449e8a72ba141bc8743efa79cd27f7367828885a1a7e28fca"
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
