# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT73 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "795900a304ff0335ce30d2bc2aeb5376676599c3b171da12b616da25848f9bd7"
    sha256 cellar: :any_skip_relocation, big_sur:       "ab4319ce0dec76ca9516ed7f5b4f384816c042fb0159c14343b7d795c7352307"
    sha256 cellar: :any_skip_relocation, catalina:      "4ceb842871da3b198a5d726ae7144d529b505e442385a80b72b0d7c9b68200cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f5b2c2ab8443dc442187a37abc00acb47f610273c12a0febb25b0abc596755e"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
