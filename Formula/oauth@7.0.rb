# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT70 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.9.tgz"
  sha256 "05fe20322256db62e7bcb5a45693ebc59829eae264f855d5b1438003ab34efe1"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "149d9aea07445c1eac07f38b230054fe40810a5085ea8ff13a8954f1a850741b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "085695ef033f12e552a9314a5ea99fe50a94b967e051525185df0450a33acba6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "93cde532ba26d7143d687610bf0ec6fdd1b83c16cee09c7db7e7bab03ee6e3f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "c2f7799408362f34b87e3a22b11eec54e723f0a1279d6c0f0e00c18524f4626c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70e1c03c3826b5bbb085c3ef4df3baff37bb52e4d1b1766fd896e0f0f7748a30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1755b7b2de1a9eb3877ccf4328e9344957108d8fb66f89f01d6a3ba6a22f0349"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    inreplace "provider.c", "php_mt_rand_range(0, 255)", "(php_mt_rand() % 256)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
