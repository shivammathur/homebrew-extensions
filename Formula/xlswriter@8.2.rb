# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.0.tgz"
  sha256 "0562a41c958a20780b492f91c3815744d976e42e4adac09edb4d2c5add7b0cc7"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d4d63523367719a9ace24590f1e4a4676b5eaa13e606c007c89ce231d0760fe2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1303c79ef719546b57492c6ffd9dd9e87c4ab8cc76ac157db613891b3891a7c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e7267d5b3348b05dd27ed622b3163f9bf072c456faf5ebc2b5119870a0162a6"
    sha256 cellar: :any_skip_relocation, sonoma:        "4933eb2f5d869537f97149612ea6025b83c7b5a8a16242c8a7655ce72d6a0934"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a125426c896b0de17b390f02edfd1d966d16972128eeafa86da41c154f076cac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25ea0f8c5e9a8ead68c1562a9acc35bbe9ead03c900d19b4faf4ae7c98f2c854"
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
