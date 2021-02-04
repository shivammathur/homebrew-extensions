# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhp81Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, big_sur:       "dba3dc7db684f7d45a3bf420d819f9c3e5876787480b2f4f7d687b83e304a51a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "58f43dc85f09f28ee40f2602cc445d0c382ceb9b1858ab5932bcb24bcfdbe354"
    sha256 cellar: :any_skip_relocation, catalina:      "354dd8a97bd8cfbe0aae7e67ea800d4ae6f36f361077430139081aef50b80b95"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
