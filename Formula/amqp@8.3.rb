# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "63392d91067a0f68453aad1ca27a6c38bc5a5a29a4602da975fb0f1288be9945"
    sha256 cellar: :any,                 arm64_sonoma:   "d6e0d6a94bd8e93f51e266b21ee0f22eccf7904ff61e20f8112eb2d4eb9fef17"
    sha256 cellar: :any,                 arm64_ventura:  "60343275978685d7c76e9afdddc0b4ba62c34edf0f934f6418cb6b948bd1f079"
    sha256 cellar: :any,                 arm64_monterey: "aaf2643159217b7ec6781b61639493746cafd0d43af41a1a6b4a5f8b5283686a"
    sha256 cellar: :any,                 ventura:        "5839973c0578db41afb56cb66e4820e0142d85802611ea0b6bca53a1181469e8"
    sha256 cellar: :any,                 monterey:       "8c1b2fd1041147a9592d57111c5ae50848e15c9f75d920f32c7eb123494fb4ef"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "0683ecbde0181f8acb755d56ab8c91f6ea76d46c8106cb76afda842a39930e01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dc3ca00f160fbeca0363c301c353a18fd5c315240ef4cb463c779fe3d261ce2"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
