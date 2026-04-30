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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9b732345b9e34991252217eb7d93e43ba5bfcbf5db3a9afb77ddc92d711dd39b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f49efccd6d94cb263ef2f403a3afc10af2c785677c7908018973d016c66177ba"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e56a80ee71841701903608b7b586c9d00c17e5ef5f4f6c0c08feb870ec9bc30f"
    sha256 cellar: :any_skip_relocation, sonoma:        "165331f0f3cef16830a782e65a9b800e0f3a2a58224a67c5d37659b92a72738f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dd300f2a5aa282b0d11c77054cbee1b46fa344b424496e544de9791704215dbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd74f33b0fc3a0a3d61ed7573975f313dbedec83556a2110a6c5cd1510423aa1"
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
