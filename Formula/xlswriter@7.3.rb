# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.3.tgz"
  sha256 "b69c168780527ec73fa3d7986d4279ecce00e184760f6572cc5e450a68b4f201"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f9653e297ad0e3e6b409be035c82f39bece5c886b81f199c1e2ec23739f8ac1e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "934fa52b1e37dcdecfe3614072e96b948096b7a73e69070c6ab981d82a6d43bd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c3f28b872a7f0d8ff141117c30d22549fdee814e0002e8ad385b6232d38e9b03"
    sha256 cellar: :any_skip_relocation, sonoma:        "9bfa1985b9d70f3d4bc49229f96158eb81514a506105ef3855eb07568cef7c2a"
    sha256 cellar: :any,                 arm64_linux:   "dab661b9af1123b72a832e8f75e45ba13a823851cdfcb5cb7449fe87b6e37f20"
    sha256 cellar: :any,                 x86_64_linux:  "c42effc6876e9f1857c42490f6fa9236e199044fa87bba7aac7d76085b80edb6"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
