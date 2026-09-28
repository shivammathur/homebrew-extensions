# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f5d89c83944b949935fff888b0e3159fc65e4cf1.tar.gz?commit=f5d89c83944b949935fff888b0e3159fc65e4cf1"
  version "8.7.0"
  sha256 "1282a69d63f7fdfd88a9fa6ce2d1546d54cfa825f205346b080a8f87ad295534"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "61a467eeac80ebc3b6bdd5ebab964920989f4eb398c982797209acc5b7dc393b"
    sha256 cellar: :any, arm64_tahoe:       "77ababc34b91159f084c8010c668085d7446d26940495b6bb68944da384b12e6"
    sha256 cellar: :any, arm64_sequoia:     "c1e1c73c6cde1edfe7972d3e729d3420b0ebb45580290dccd2024c90a7c25d75"
    sha256 cellar: :any, arm64_linux:       "09b074c45bad93caaa0b209ab91b8e219ed8fc195a741faa6a4efd82dedbcfec"
    sha256 cellar: :any, x86_64_linux:      "49cfb93d8d963486ab11b58284c6a929cd1002f3686c4ccf10aa177ccfc55684"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
