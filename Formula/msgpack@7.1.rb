# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhp71Extension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b7eca115963fb7e129d19859adfddb75744cc5a1dcd7a3e56704168f41d304dc"
    sha256 cellar: :any_skip_relocation, big_sur:       "50ac13aa700bd2c475af28effcf750053266b6761f61628c589bc0d123bf7ef0"
    sha256 cellar: :any_skip_relocation, catalina:      "6e138af9f229bd438ceca5da382c8efedb446e5b37ee8b3803a7e5f00b33ecf1"
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
