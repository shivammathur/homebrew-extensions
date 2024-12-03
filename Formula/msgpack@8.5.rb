# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT85 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6a0089c0ba848a3b7e21290cb0ffeb50d2187fcf18d95b995a6d9e94e7501dd0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8c9958e7b12d852a3a0f6f1923aa7ac05786a00d852c207eca78d27b9eec3cdb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "260945ad4d2206c8e4921c90fdcbc1a935e8c2c6d01754cf3e365392d6ab61cf"
    sha256 cellar: :any_skip_relocation, ventura:       "e0dfc07f9797aa2a92be20254097bb435dc96c9936665c059e432c9aecf931aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34c9f5a0f1f7e6ab06c882f158e888c1b12663dfbb084b5e3ca2acdb74df9da5"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
