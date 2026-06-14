# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "799a753091257b162e99106c883b06a118323faf5bfea43e98f1d2e4a59d9eac"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e0a8260080cae48575a3f5593e4b741050dc799a99a1ccf293cb3d20b21c5fbe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "455b12e953803b7e9df134edb3ed51e4109c3b30d45866abb8459263d7605e25"
    sha256 cellar: :any_skip_relocation, sonoma:        "ec0240d34370b4b08bd1de289abe22701e4e23f458688dbd8b69292b4848cabb"
    sha256 cellar: :any,                 arm64_linux:   "e469f30e444edc136e44049164c503361299fb25cbe4f8eb9128895fb96b4cb6"
    sha256 cellar: :any,                 x86_64_linux:  "6b63c9aca29062717d29bd8013005481917d0aefd14c14cafbd07e0d5319b0bc"
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
