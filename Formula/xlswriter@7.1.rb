# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cab9d742a3ba0b1e16ec3e57e1d9cf5fe507f5b33a1add942bab053a7ab1ccb4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cc9bfb2e6564d0d7c283638cbe6352bf02c45a20b1f01d1586b0e45326c73d63"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aa6c5256410ce9af5f07eed5e15d149c2c14aefff2402cd1b7a7c348774206be"
    sha256 cellar: :any_skip_relocation, sonoma:        "feb36b6a21bef4150fb342ca7b78612720dcfb0e5d9fe1483a9e447ddcab6835"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "78a009db0e982fb8be57c6f485503f4952c7e89fbe19d43dea48d8bc457ad8a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "edcce6561d5655968c1d2fcf96c2fb0f4a1dbcc9cc8580a638ab33f4838313d5"
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
