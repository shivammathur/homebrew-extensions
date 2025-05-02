# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT85 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1c1d3162f6e543aea028d262da8da0821b1bbda294ade1984bd8207c938cf9fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8de22c9c47e53161ef33a627eccd362a0442e987b3958fdf8578a9f24fb4b451"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e18ce3a503812b44697b8d4d0af7270aab3874e8f7fa0282c89fb24d3f51a9b7"
    sha256 cellar: :any_skip_relocation, ventura:       "c8ba43f914b99c024d152d0e9e16fd506620de0818a5d9b46f900eda997662bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dda1b56d5c42694aecfbb8eaedf02a6584d53e7f781eabe8eab4c6bed319fdfd"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
