# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.25.tgz"
  sha256 "c4e7bae1cc2b9f68857889c022c7ea8cbc38b830c07273a2226cc44dc6de3048"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "35608e41223394f71ee284488435e4f1753e38e4c4e57357e486256f89ecc625"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9d9557ccded0d429ec0f0a0829cb7daecb4bf7a906ceaf9868b3104ab8d12f9b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cacafd980628a6d271d8943f039125b7c2dfa0dbb1be4d84dc1c0ba1f2ce8d80"
    sha256 cellar: :any_skip_relocation, ventura:       "0e368880e836ea2659afc913a4dbf939ca977ab2b70277db1d653b24b730fa99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c54e39b701e5f98269e48c9c42103907b73b3238a7f6f589388d87831e593d40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c8ae303d4216bd9077abb4673fb18f95628b62920b7127d086cdaef9e60d3e7"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
