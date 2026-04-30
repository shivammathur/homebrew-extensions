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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "485b9b1167789d4e1b4a5ee931c34267d8da4a0d0688a874916fbd0f98181cca"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d57ad580af7b88270b42fd599b129d63877541e3e52997d517efff84bbe7397a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "28469290fc123c6c4a1429b25de91b0825910cfa0cbfff06db70d8a56ce10dd5"
    sha256 cellar: :any_skip_relocation, sonoma:        "bc49f09bb5db1fbc0b72f24ae99b655ee634d72800406dfcc1a37f8ca0972337"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70b0c8583feda00762732eb614e2e7f3d7ed9559e792eca464e81042b95bb1a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0acbaa4d0d02bb65a4cea8f1727647dec6b2d393de0729911abf518595264756"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    inreplace %w[msgpack.c msgpack_unpack.c], "zval_dtor", "zval_ptr_dtor_nogc"
    Dir["**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
