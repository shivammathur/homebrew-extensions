# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c815fd2a7d2074b5033aa84be30104de3b18a3724f466e934aea511049934cda"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c05dd78e8c0be0a7934a71530ddf050b1c6446c51e96b092323adda7e1cb6627"
    sha256 cellar: :any_skip_relocation, monterey:       "474a0bf9e65095009f1c2f5365a51e4c73777b0169b06d1d6822b930c23e5e0a"
    sha256 cellar: :any_skip_relocation, big_sur:        "3392201b93782e5066aa49f94d7c7e929d0d2bd3f1b1b9dc9ba379a0e60904df"
    sha256 cellar: :any_skip_relocation, catalina:       "59b9342077ab5b5b728fd0f7feb3dc538ba67608ae0ecfd68b2d0ea0fefec442"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1c10b331b96cc7c08466e28047c663d34ac1857ee494f5c09e0d03f17d0ddb2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
