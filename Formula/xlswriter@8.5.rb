# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "17e743b7a1b380a2a17984555dbb8939dfded9d2471a80095eadc888592d5ea9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "112467465c5cacbf0b42b13427d99a510abac5fc7a3a4de2c9d5afe4361f13c5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d593cb9e3f16e20f61ddce514b1d1f8cc3503ed4bf7265b93addb7c688a12a8"
    sha256 cellar: :any_skip_relocation, sonoma:        "46c0d94caadb9a4c7d81bdbbd7a3519af664eebb5d3cf4455e35869eedfc80ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6c6cf0c3bc5b8783fb4e9d78b76884edfef6c9885ce7a2103342a5ea7a77d3b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dd5e373406deabd22f4e8fca0b14840a1be5d0b2491122418294c7fb38a65a8"
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
