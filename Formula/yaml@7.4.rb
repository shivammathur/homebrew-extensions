# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT74 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "dc0ea64ae4eda687f3f27a7efe0417bd92a3a57dd41f79ffb96df868310310fb"
    sha256 cellar: :any,                 arm64_ventura:  "521551a9303962ad2a41a4da6aed54fe01f70011852790a0ca1849d56db1bc7d"
    sha256 cellar: :any,                 arm64_monterey: "517a830a8b503888833a37f1148cdbf9170e67bceb0cd886f9e15f7c574cd6a0"
    sha256 cellar: :any,                 arm64_big_sur:  "d48696e6267fe21a05cfc33fdd786b4a6a63d8c318df177b63c37809c2349219"
    sha256 cellar: :any,                 ventura:        "5fa6949c8ad043e4ea3dc452fd59caf4b3044f6cbcdcfced7e7a1b12370c8856"
    sha256 cellar: :any,                 monterey:       "7e6f6f869407bfc36b3bd472d7278291589e6336245f91d089be5483a2dfb01a"
    sha256 cellar: :any,                 big_sur:        "28cf61fa926fc6c3f74f9b055570fb56e95a9bae4457ed56c0e7d470a34f8dd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "abf74ba02a9c95107c8f145d7432138d1b72d5457bcdc8d59b355cf905db2b26"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
