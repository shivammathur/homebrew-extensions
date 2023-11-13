# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f6b4f358abed83fb64f2122865bf21308e0a8351275fd01c7d1b759553f77cc9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8f6beb6dd00173379e367b8dd1a86e36406b4cc20a8e7c4a13ad81445694bb49"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "365cdbd9c31209986515f0cfd34e1eec3ac23e46399cf56971f8839538c4a905"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4bbb5db169387210e3ec0a36de31c5875c8936c2d242303992c4e10eb9d92dd4"
    sha256 cellar: :any_skip_relocation, ventura:        "9c3fad4d35116e3cbe82bfbd8a8673e43d9171840415d21ac890b63f256c67b5"
    sha256 cellar: :any_skip_relocation, monterey:       "f45482654a19c2e66b76d10c72f4baa14a08a49947ff702297714c253e24964e"
    sha256 cellar: :any_skip_relocation, big_sur:        "985e5bab3d70318b11c2a8cdb4465eedbd294bf3a56cb23363dc071395fc6ea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9039e6885dba869f5271bf178daae244183100843b144bee91e817876749504a"
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
