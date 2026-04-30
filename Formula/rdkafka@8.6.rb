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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "4a251c98b3f7a6716a3bd60727a01b1956386390b53aba10ee8ef7df4be9ba15"
    sha256 cellar: :any,                 arm64_sequoia: "463bb1e63e2f824e3d3ca7523dc0da93c59e9b29afd86f5a12fbd481b8e1081d"
    sha256 cellar: :any,                 arm64_sonoma:  "55c625f94e599c7f43ba42b788ad4100e5cfb0e11dc6b2600f63160f5de40e79"
    sha256 cellar: :any,                 sonoma:        "b319bf65d5e05501594fb8d038368a59c20c906ce2ed82898844ab9ed48c20ba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c4582b70eaacaa73c2de1a7fd9228d80a582af8c6a06f8ce645bb92caff87c4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43e5567722b922afa507b2707de052acc4749876acac9f6d408a021afe78f939"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    Dir["**/*.{c,h}"].each do |f|
      contents = File.read(f)
      next if contents.exclude?("XtOffsetOf") && contents.exclude?("zval_dtor")

      needs_stddef = contents.include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof" if needs_stddef
        s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
        s.sub!(/\A/, "#include <stddef.h>\n") if needs_stddef
      end
    end
    inreplace "rdkafka.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE()"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
