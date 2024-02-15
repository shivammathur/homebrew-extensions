# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4792102c07a8f1256d4a1c847e6cb34b77a331c981e0c4f1f89ecc27d5520a7c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "53c107b8b4742d71f54b78ec0e5246c8133f4873462df61f56dc57653f9f5a84"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0113157e592b93f550a78e5bec4ed6b4c99eeef48abe7f8a6099d671fd643226"
    sha256 cellar: :any_skip_relocation, ventura:        "ace2a21b94e89d9cda004dc1b921d22af78b29c07317b0d7ee045ee985fde4c2"
    sha256 cellar: :any_skip_relocation, monterey:       "b0982ebf471f78929058b50152c986ea2a0bb3274770083af49a81e8a22356b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "041d138b7e5dcba7728536992e493e5b72a34cd2cc09055e2652ef5de1c06ab7"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
