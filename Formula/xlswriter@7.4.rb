# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c0dddcca0c7c9d45c59d6d8536ffdd8b881f10ab0a31bee69efd10cdd2d24d1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d1e0795f53c14a30f38497a569def56a5d45ce71556df2130cffa8d9fe9d04f6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f8bd94fd1ed0acb24ca70b3541304df3e3b35e7d850b2db3219bb768df39da9e"
    sha256 cellar: :any_skip_relocation, ventura:        "895c66bea91f3fda32faea680c79d6ccd91a28b6d71142cab5eb395335adbdcc"
    sha256 cellar: :any_skip_relocation, monterey:       "30edf6c59bb3fef883144998271f7f153819eada2d08886567def8c3e19954f0"
    sha256 cellar: :any_skip_relocation, big_sur:        "88571fbea0e955d9a2c07ae4837fb6ca02867a2f999880d4b38e48d903b23f11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a32fa94f9720946cc0549fbaf802664480ac5b6d881b44361ef4ee9944adb0f"
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
