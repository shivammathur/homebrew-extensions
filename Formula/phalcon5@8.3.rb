# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.7.0.tgz"
  sha256 "1c82b5c4d7329229daa21f77006781e92b7603627e7a643a2ec0dbf87b6cc48e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d7b8bc37433c82c0ecfde26efc6b7c8d9640771968c83016a50d21139312c54c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0c153eb31d9aa65d83d33614a3e7a96be5d2b59a1addef97130c1afe964216be"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "336e5849538994376967bc18105bb8239a5408748da23921e7aaeb4f0235f478"
    sha256 cellar: :any_skip_relocation, ventura:        "56ac27b470ddd36131fdef3fe323774d424fca68060334662c70914a1922af01"
    sha256 cellar: :any_skip_relocation, monterey:       "776afff9c6f9ee3714be15d24e24b5e00a4719bcf3b60ba8842395db8c9206a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "024a0bcb2ffd184b3971f41d10ae5fdeb94fa1d5324a6ed13d15005c23b020cc"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
