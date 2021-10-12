# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.0.tgz"
  sha256 "05698726e123e4c339ccaaab80f0a81705b9bc9c21377f0951c9ad51df4718c6"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cb72c798173abad55e9e1c17310af9fb9af23f8f7d4964ce80ab1fbe42ee5dc6"
    sha256 cellar: :any_skip_relocation, big_sur:       "40d262019066b7a26f4e77acc3d037ac8fc6bb912a1f4f5c49c4b29081c945d8"
    sha256 cellar: :any_skip_relocation, catalina:      "7c9fee4fc47b4a36e87e267c552ec4f703d6cef8f539109d550fe890eb9398e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed5a704842b2f695d4e94fb7474644db9f367c07d40443fdcbed040c5cff27ef"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
