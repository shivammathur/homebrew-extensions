# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.0.tgz"
  sha256 "46592a6576c2f42927659dd00dc6c3f39f1fcae7374e95e1f4e11f8ce4f477fc"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "56a9455cc92fa213ff06aaec099f8e731f371eaa4db7b7abfe3a9f815ae3884a"
    sha256 cellar: :any, arm64_tahoe:       "3ddf475fb4ed4876ee10569d73e8ad8f814bccbcf3ba5bb9b628a57a9702c1db"
    sha256 cellar: :any, arm64_sequoia:     "8f980f22a86f361d7d889143ab8e92d0661cbb27c7162fc795931a1880fdbaf4"
    sha256 cellar: :any, arm64_sonoma:      "33afab6f9be05e7f5ed6364c83abf2de901984b409f6c8a40b8599d1d5822910"
    sha256 cellar: :any, sonoma:            "89dd6233f6cfa63d0ebda0b0d16f59422ca74370c897865142ede4fb663e6cc9"
    sha256 cellar: :any, arm64_linux:       "e7f52b180a9dfc1770e8153d50ed8216504aaf6bdc165ddfca8a46ba84115d8c"
    sha256 cellar: :any, x86_64_linux:      "5a57c4aa5e1de7c84da05e55db81995d531a7595df60e5cec746e630fa80f38b"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
