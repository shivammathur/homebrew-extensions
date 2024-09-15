# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT71 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "386d31ba57b456b0f23ee4156bc19271dec6be838ffd8a58363a18e260b47db3"
    sha256 cellar: :any,                 arm64_ventura:  "7416f8e98373812c0190b1598ba89fb177c4473ffe8f3f4f292d7466b9d89117"
    sha256 cellar: :any,                 arm64_monterey: "9a140e97e0253add61c9bec9aec23bc8224fd8d72f4421f9c78ec6468abd6fea"
    sha256 cellar: :any,                 arm64_big_sur:  "a4fa35c4416518395ee307da5f83da5610dff3706c7d4ceef79f486c6697b89d"
    sha256 cellar: :any,                 ventura:        "ced70b568474dfca5bf4b180c7dc08fee6539cd50f450f7b03167a74ca3f2514"
    sha256 cellar: :any,                 monterey:       "b6477e47d9c6a7f372556e76841c2fd11f395a6c297b00f1bbd167b545e47c05"
    sha256 cellar: :any,                 big_sur:        "9da9497a241cf6cc52d776671712b8ad17c5ac7acc3c4530b53a75f36c22caaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1b32a1c1c737014509a18feb41b6ee4fa063ce4caa9ea6949d346745d9d79235"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
