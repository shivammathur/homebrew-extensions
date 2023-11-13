# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "34d4bfac92e07f071f4d36c2c2fe4054ee079cb6ac18a15baa24cbce0fbd8fcf"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa92f6f7b4c69f12965bd5e1c7efe9b88c370d1ad03e3154228bad7ee8dbc25f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f5a20dd1c6db9f7b157ae29413603eecdd5a6878ccf2de50fef0d1e57ac4ae9e"
    sha256 cellar: :any_skip_relocation, ventura:        "81c01edb5679185f2bc155d3e428cd021838d7db899ec0c88d2c26ee6ce5c7f2"
    sha256 cellar: :any_skip_relocation, monterey:       "d7918587466d0ce75b205b1580fff6cb9fdf614b0e720ba8e481409437109cd9"
    sha256 cellar: :any_skip_relocation, big_sur:        "e552116abd35b9a99fc9403bbafd839a77d4b0a0ad26b7c95bd55a7101393fbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c3cdfeefc263701e51a322649468c03a15a5b722bd6f9024572c892bbc2b624"
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
