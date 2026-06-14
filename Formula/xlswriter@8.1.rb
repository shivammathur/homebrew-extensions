# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fb3040a78df7cc6c8a7bf1cec3cc69c76bba0feeceda6c53f257b3e820d89095"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "738f78545f2022a5c01c0efd41196a5610fd0aa05fb360c6e3219a56ca3eee50"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "273125c3041fc71b7d8d9525356260f74700704da69ecd0a57806a5bc89fa043"
    sha256 cellar: :any_skip_relocation, sonoma:        "adde227761c44ec6795b5fad6c88821ee1d3e36ac9be59455688a972b40c8ead"
    sha256 cellar: :any,                 arm64_linux:   "97c604acc78dfd2a6d1a3d48ebdefa802af3053ed1289e9579bd7a22e43dbcff"
    sha256 cellar: :any,                 x86_64_linux:  "e78bdd797d8cf8dc191aebb21ce31c9128d369790bc0a198cbe1f630e6da3f7a"
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
