# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT86 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  revision 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "45b7d65042ce18980dbdeae52625e8d88c13e379546e2bb085562f7dda5831f4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b04162043557b58bd7842327d62cce2838cd9318859dacad72d461a23b86c56a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bea16c30f07d638c9391017e5d3b7883aae082fd990c93e7b9f2fbc910ebf0b5"
    sha256 cellar: :any_skip_relocation, sonoma:        "01977337ce8fe643b51d3486183e1657cd3a187dcbc1c7aebcbee4f8b34697f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d16687fc7242fa3055b19f9a2e69b1481d425d93cfc782ecde7b4dacd9412c6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04b45b6405bc491c3b674315615b63b085a19824fa1b42c2aba46bdbed5e9076"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    inreplace %w[msgpack.c msgpack_unpack.c], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "msgpack_class.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
