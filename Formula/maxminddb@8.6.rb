# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.15.0.tgz"
  sha256 "49412f02d31d28861f56c05f043ed21a1e8c444b53ac47292da502a4d1fdaa2b"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "bf5711396dd193c6ec01d399a2287be628b8528ede849918611201cc2f50d9f2"
    sha256 cellar: :any, arm64_tahoe:       "13bebd10116931e32ad902ef479d9cc066f86f085fae1b631c47ec665b0ef31e"
    sha256 cellar: :any, arm64_sequoia:     "eb49a0086704e939d99f7fc67b4ce70986db2949d0a537a6f6434f4f4c5901c5"
    sha256 cellar: :any, arm64_linux:       "f1df8cc07da4e8f0bcbd56904c3ea3e812d5a5032d483f7fecaf5fe59c50d475"
    sha256 cellar: :any, x86_64_linux:      "c20af53070121eee7d664fedd74b187672fa50065a613463603f5d001b3ce16e"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
