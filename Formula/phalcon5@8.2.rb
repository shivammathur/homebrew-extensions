# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.1.tgz"
  sha256 "e2a7720c066e7c0d1be646d142634497672b64a4660cea4edb4bcdb2df59be8a"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e88c58e9928613c4e473e8895402927e8ca25af2084653c3b8fa08ba6287e8af"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25f57694234a8d19998c9c560b95036af014663b41d270a13e8ba68581628394"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5dc9b1d824342945bbde508c914a5a80b290363133139f46e9e9e95aad691538"
    sha256 cellar: :any_skip_relocation, ventura:       "acf3a561b3c3607f3300a7d5ffa6c8d4b33a368babad8d7708de08e8eb9eaa3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "028be6e8eaa6c0c9f3d7628637fe7db2961078fe14d2430ed8254a7236a83754"
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
