# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "cbc6cd34109f792e2e54ce3c45952fe9bdb7c27ba1ed1ee416a72cd2aa536fd1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5f1b0b46cebf36e66f3d5d575507110bfc3b0251dee62f4530454f3fd1d44060"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0733621296076abcc8d7f6c77ebe8c3b0bfb54d1d9f4b9e40bff23f237550528"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2fefa6fb765ffd2b7eb732489b003a391eb9258bbf52dc9bf33256a1a23fee3a"
    sha256 cellar: :any_skip_relocation, ventura:        "95ea106017089b7281040c86c8caf1e5324eeb655aecf2d9c45c3cd8c644130e"
    sha256 cellar: :any_skip_relocation, monterey:       "4582bdcea84a3458f97d24b86bef995a9d2a20e783ff86aa3cdd90f8de6ee1aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24382dfb372abbb3b9dddb66cb2cf5dbc0bd0bfd371cd044b039996d5e6c245f"
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
