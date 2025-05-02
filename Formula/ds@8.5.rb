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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c9e1bf00fe6661cd6316867bdd7557352a4be3602ae86f15afedab3e21bb8401"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9f5dbc1aacf0473fde41d677805f3e13bcadcdbfbc5b814841c147272604df21"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "76f21e0946622f27b128a5f98f56fc79c11571741b74fb258c15370c6c8c5259"
    sha256 cellar: :any_skip_relocation, ventura:       "ab373dabf5863692185190e628629a200c43be1a72d47b9649f716e50c14ae41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "57e5c8d46db7e5790ce16ae4ee1bf3216a0d45ee9c7cca6b59bf5660529e7531"
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
