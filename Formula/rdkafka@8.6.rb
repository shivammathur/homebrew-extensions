# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT86 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ddb87a250c70586682157e086fd5e861a831c88c49bdefc8ef684086249252cc"
    sha256 cellar: :any,                 arm64_sequoia: "bcd78b0ba8dfa42ffa1693d7bcf77b8228997e22373afc154a2c5585d139573d"
    sha256 cellar: :any,                 arm64_sonoma:  "d6816a9be65022721b23bfec122dcc5b5642f6a28a2b377d3b4809538b7d1d8e"
    sha256 cellar: :any,                 sonoma:        "441161a50792b161e763aa49c68114bfbc5f968473c2b204cfb04a800c2c78bc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb26802a522ef2bc282e04eb8d7e0de55ee3fd984ec59ec728aa680f7e5bb14f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca660b28ca0e6f4fea78fa11b110f25810d42de359b33d9e01027190e37b60be"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
