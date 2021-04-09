# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhp73Extension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1daac878d3d85b4044518e096cf57d98d75a6100a8a05d2df8114abf635fbe62"
    sha256 cellar: :any_skip_relocation, big_sur:       "79ebdc76c521375d6427e51a905f81381da74deee2d0e24c5c1285318e7fabc8"
    sha256 cellar: :any_skip_relocation, catalina:      "4efe6796c44eedc85a62196fcf66d9cc2aac1958254b89d995c43e3490859ebe"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
