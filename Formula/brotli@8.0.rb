# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8c4b89739478d303deb42024eff8a41ae563b9ebbef6f10caa36ecea2c384a90"
    sha256 cellar: :any, arm64_sequoia: "c5ff317f5ae327e68b2c064b2fa3ed37789a9c12fd5371f8cab00f77402063f3"
    sha256 cellar: :any, arm64_sonoma:  "55f7db2f3231c8320f015c92c0fb8411d580b503f8d73f671f299754ed5a94d7"
    sha256 cellar: :any, sonoma:        "9947b0de497dd8aed90587a99dc3adba4a94ffb00b2f033140d0ff862559cb8d"
    sha256 cellar: :any, arm64_linux:   "44b92ab2647f7bd0d1c57139562167c137964ac29da3aa4cf5f7edc7200780a2"
    sha256 cellar: :any, x86_64_linux:  "c8add26f257c2411a8c2c4d63f2ca7bdbeab09e7835fdd5daa8cce3a6a5c1da4"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
