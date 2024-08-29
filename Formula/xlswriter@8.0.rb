# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fe5f95588e1f774c0a066c94416ed43acf0a782e86f042fffe2f61bbdcc00da9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "237f3e4955d35d5297dd9f5f036c257f9da70a60817ce06da809043479956b7f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5daff39420f49570455f9f9f0352b2e248de323c0dbf4cb3b56c6a7b732d67e9"
    sha256 cellar: :any_skip_relocation, ventura:        "08de7346188fe84e92c31bc82f2e30148e89f4daaef321ca2ce287eabbeeb921"
    sha256 cellar: :any_skip_relocation, monterey:       "750426a1b21ae1ad020e25756d47d760ba1e7d1ceeefe9d84e7674f70ee034b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a28a2a3db61e6820a801b67c8faa9ed659f48b43856c5d7b4f4a29fad78d81d6"
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
