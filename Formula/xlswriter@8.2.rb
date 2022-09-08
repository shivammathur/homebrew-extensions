# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b21d1291fd45c8686fac29464e02d78466b73669ab9cc784ac83aa1ee3056207"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9e02e67d7f4f11c8b440ed7fb4a766b0f75c78ddc6a990c86249a9b5d2e7127a"
    sha256 cellar: :any_skip_relocation, monterey:       "600b563f958a1729eb1722c3302557e9a24fd100b751ce593e761d88d0109ca5"
    sha256 cellar: :any_skip_relocation, big_sur:        "008ffd1e4e86006dda8b41d915128c6330fc66339198b3fc40ca012835cacf18"
    sha256 cellar: :any_skip_relocation, catalina:       "6e70f1460950b3a99ccf10df2a9a317a3aa6a66f8f3c7c80f195d324dc21f860"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fdf135f5f14d3cf62f471fdd13d7fca29aaa1ce206cdeb3ba7d791812ff2a340"
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
