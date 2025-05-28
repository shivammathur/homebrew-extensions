# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4e18c157649f829414569025d77784003ca3ed83d8fe99021db0ec43263ab39"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "14c049fbbf0d2f7c6c011ea4c62faddd20f92ecb89a069810a0f3e4fa9485481"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ac34a458dd619dd08239bce2767d7c546a2ba7fa758ce1a0e231b02bd98d48e5"
    sha256 cellar: :any_skip_relocation, ventura:       "95138ff4afa94190bb203adca0a8678563d234f06a12390add09bb8173864971"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5bc755c3f0cffbcee11d58508bf9cfcc02326985e6b337e5c5ecd6347f8ffd3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7fdd92f8949e44496bfa5059f1adbd7405665af42500578ea8e6f6e7c98cd5ac"
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
