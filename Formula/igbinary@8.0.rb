# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8ec005e3eb5487fb8218dfde220d364259b03e3fea1b2acc9536d3ba3a9a2851"
    sha256 cellar: :any_skip_relocation, big_sur:       "3da771857cc11b4750c441712992d13b3b4f591ed4a19bf8c319429811b8ca5e"
    sha256 cellar: :any_skip_relocation, catalina:      "7d980cb63cfcbf8ba346c9fc4b8e51a7f5b0fb8b60ec0fb776b9eafb1a1343d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b2d73b95032681f06cf04ecf179bd9ab20faf3e728f584cf13fc0c87924f26f"
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
