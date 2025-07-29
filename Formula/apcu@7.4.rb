# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b403e2ae0e28ef7ec628c77d0b114da51a8a0faa6fe9144199c1350bf58e036e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5477ded9649caba26f463394983a23fee5f5d5151baf7e8ceb0eb80cdd418a99"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b393c44391950f8b1d0d07e67047813c63d6c5d0fc4b1ce152c533551b8ba860"
    sha256 cellar: :any_skip_relocation, ventura:       "062c2a45545e7151801266adff691bc96b41e13b88c4d453eeccc65c3e3a66a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ba1a7c0ea6cc2684cdbd267bf31326167f2c96e19375d3ed9d70c8489b08e42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d66abf41527842996dce96549308e68175e21d3a65d5f70d2e1d91f841882631"
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
