# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1bbaff0e9c3e91e41eb999454c9ea60e10229ec0ec1678b59b1d4f748fa182c4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9f8dca77388a4c86095b5cf7f23acac3a8a8d24410e1bf805d65cf77096f0ea5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "af685104d44942568302be3d98a61ccbd3cdf0d0fd1ae89217da11785b387206"
    sha256 cellar: :any_skip_relocation, ventura:       "5c15b5a7a9cb9e4805d99151fe72b4091d30d4c2ab35eb4ca454ef04d347a238"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3fd289707827fa21f396e52d1f04345ab8d38897e5545eb42a74af689917f5a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27ce59a02d9985cb9df31ec164137006d8346c7c5f82fad61af170418c351703"
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
