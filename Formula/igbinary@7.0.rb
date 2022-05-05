# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "05c5455d46a06ca051521af65fe2fd4db96c6ea9f869fcaaba82ecf8ec298374"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7b85ffd66f400e998790b3a0a649502024e33c2d87ea115f5be817fa72e4d388"
    sha256 cellar: :any_skip_relocation, monterey:       "818492e6d8b97de1b0b80cccd15aea8b9bb3be5a7788d86fad1d93a6c675ddcf"
    sha256 cellar: :any_skip_relocation, big_sur:        "22a676bb9023ef19a7d9ea372b2ad8a5b0e74c75f42e2ad41d4e3b32a81824ca"
    sha256 cellar: :any_skip_relocation, catalina:       "caabae920089a634ae37cf050cb0539c63cd8ce056056817e9f745f8a2b07c85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "46e1e371fcd47f500634342b3470dc042158c919cd37387cd5f7f42ca3632ef2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
