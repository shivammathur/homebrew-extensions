# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "deb718c878f8a47325e06aae1560ca09d9c5d02328f4f4ca499463f49aa94aef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "69a150eb96acc60582430cb1789a4e3a1a2b9cf604b93ca0d1bb6e2490746edc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6a85715e397dc501cef21ad739f9107a3b8c80b482060b4704bddc4e4e7260e2"
    sha256 cellar: :any_skip_relocation, ventura:       "abe2316020939cb48275b3bcd81f1460a8ef87cc70331d6eca9cbcb251880aa0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e157f51133fad0fb95895fde08d453ba2e5df8803207cc67c4371273b217e000"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6f4181511f7d74b8fc34290188191c6f09b337453dbe73e3cce0bf8da81a719"
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
