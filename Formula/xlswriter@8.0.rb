# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2c4323c06e6f88c70017149cd094325c9a65c13f9898155ee8879c818610d8e5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3fac809765787ea1c755cd48fbc18e1f83b613ae24ebe106e01618fd4c2dcfe2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "46a965bb38528127e6a855cdc24c4d1283167863ba83e3069f7fc95911b3a8ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "0fd864005b511ac6b6649934f3939e63baad9ff79b97dd1d389e8cdd1df5d53f"
    sha256 cellar: :any,                 arm64_linux:   "c4aef045b27e0bce0b382f5a2ba623b022832ac8dc649e50e292d8287b6f7d9f"
    sha256 cellar: :any,                 x86_64_linux:  "b5bb251fd137d1d8d2b1872f97d3e8d78fd89f0c2e534db367f8f10efa708ffb"
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
