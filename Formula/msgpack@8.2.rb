# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b7f512bc9140c21423ef27ab0c5750dfdc1efaf3f5091792ce139ac7d47fdce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "39a569e4a2084c36c098369dee303f057e232290ca4daa816c887bd2ce39605d"
    sha256 cellar: :any_skip_relocation, monterey:       "86d81bb4df5a4930a20abe7d8ddf18314c42ebbd24561d3ef67b13c9240820ee"
    sha256 cellar: :any_skip_relocation, big_sur:        "87010ce20f70125702f704b17f32846a90313dd39234c963f33311f690100e1f"
    sha256 cellar: :any_skip_relocation, catalina:       "02f998bb87e6cb0905a0740c6037695d458f042b186450d3334b1dbe40987660"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "63ea42e5504742a93bd36aa047eecb79e9cdca4ad178f48bc4c3ab1dfffe330f"
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
