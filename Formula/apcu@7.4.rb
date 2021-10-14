# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1428327235aef2289cb536cabad3e740466c04864ec6db9b5b9d122573f4b645"
    sha256 cellar: :any_skip_relocation, big_sur:       "97a8d389bf49eeac89b12a96f0bdc2adcc21a89dc2548767e11dbcb8a5a3cea5"
    sha256 cellar: :any_skip_relocation, catalina:      "22c0ecc96027a9b9d395c863c46cc38d0070cc8ede043b2f60df4d0ee989e3cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "933a7e4569eb3662e4f91e47302d9279c1be971f4d9f57d50fd70a0939df75c1"
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
