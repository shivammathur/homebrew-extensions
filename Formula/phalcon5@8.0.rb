# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.0.tgz"
  sha256 "b65c663fa36e2184289cde64d30c5b62b3d94974b9e99258a49a9a3fd338c788"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e1826ce7a0710c50f14417ecccea86d22994fd24e9c65ab4b70ae9ffae6d1b97"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "98ea653af2ba1c539742db3ff9632d8ec3d22a56ecf05c44ed8102e2cbadfd09"
    sha256 cellar: :any_skip_relocation, monterey:       "2fa78073efd15ea76c40f05838a29d1bae3990d643a8f00526846b66fc942d3f"
    sha256 cellar: :any_skip_relocation, big_sur:        "63ac92568f9ece749c3bb077b19b234372eee4e6f565dbcb343b209574ad2fc7"
    sha256 cellar: :any_skip_relocation, catalina:       "ac58b4ac48df78900ccd29e516ca5cbaf193140cabf65107cb4bb45a53d3c6ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e89dbd33a374d87893a513d9314e40bfe3e83772cf5ca766bc5705329f9be505"
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
