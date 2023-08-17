# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.0.tgz"
  sha256 "0de5b87215177d1e3ea30dd5d71d89e128ee012b7ae1ae5bef6275a76659905b"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "beecdff3d680be6da9429ad1c0fc196d5013aa8441c80d45c273ef4ba9e27d98"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2ca1a75965ccd111a351587e172dadbece49d8d83865760ed8cda5a10818768"
    sha256 cellar: :any_skip_relocation, ventura:        "c75d1f7cd585e6a8ba70fd16b83d98d58c05bda92ea26e9e3766901849fb9e90"
    sha256 cellar: :any_skip_relocation, monterey:       "ab9dacdb85e5b08fe7b68c9fbb7fa96507fdc04e86dc9001e6c75ec1fa8e7f1d"
    sha256 cellar: :any_skip_relocation, big_sur:        "5ad70630822290757bc30d5364c54fe6cee23d61e181f92b4dc2bb79d758ec5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "614a2938a108a88956dfcbe688a60f9dcd3c02283f90858b0f6d855af1a17a92"
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
